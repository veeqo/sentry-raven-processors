# frozen_string_literal: true

require 'spec_helper'

describe RavenProcessors::Fingerprint, '#process' do
  subject { processor.process(data) }

  let(:processor) { described_class.new(double) }

  context 'when data contains exception' do
    let(:data) do
      {
        event_id: '4f56e5382be8419aaa47bba6c2b20842',
        exception: {
          values: [
            {
              stacktrace: {
                frames: [
                  {
                    function: 'block in safe_thread',
                    abs_path: '/usr/local/bundle/gems/sidekiq-5.2.7/lib/sidekiq/util.rb',
                    pre_context: [
                      "\n",
                      "    def safe_thread(name, &block)\n",
                      "      Thread.new do\n"
                    ],
                    post_context: ["      end\n", "    end\n", "\n"],
                    filename: 'sidekiq/util.rb',
                    lineno: 25,
                    in_app: false,
                    context_line: "        watchdog(name, &block)\n"
                  },
                  {
                    function: 'parse',
                    abs_path: '/foo/bar/baz.rb',
                    pre_context: [
                      "              if Foo.bar(baz) =~ /FooBar/\n",
                      "                raise FooError.new(result.errors)\n",
                      "              else\n"
                    ],
                    post_context: ["              end\n", "          end\n", "        when :raw\n"],
                    filename: 'bar/baz.rb',
                    lineno: 272,
                    in_app: false,
                    context_line: "raise FooError.new(result.errors)\n"
                  }
                ]
              },
              type: 'FooError',
              module: 'Bar',
              value: 'Some description'
            }
          ]
        }
      }
    end

    context 'when data already contains custom fingerprint' do
      let(:data) do
        super().merge(fingerprint: %w[foo bar])
      end

      it { is_expected.to eq data }
    end

    context 'when data does not contain fingerprint' do
      it 'returns data with a generated fingerprint' do
        expect(subject).to eq data.merge(fingerprint: ['FooError', "/foo/bar/baz.rb:272:in `parse'"])
      end
    end

    context 'when exception has no stacktrace' do
      let(:data) do
        {
          event_id: '4f56e5382be8419aaa47bba6c2b20842',
          exception: {
            values: [
              {
                stacktrace: nil,
                type: 'FooError',
                module: 'Bar',
                value: 'Some description'
              }
            ]
          }
        }
      end

      it 'returns data with a generated fingerprint' do
        expect(subject).to eq data.merge(fingerprint: ['FooError'])
      end
    end
  end

  context 'when data contains no exception & no fingerprint' do
    let(:data) { { foo: 'bar' } }

    it { is_expected.to eq data }
  end
end
