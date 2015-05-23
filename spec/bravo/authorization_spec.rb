require 'spec_helper'

module Bravo
  describe Authorization do
    context 'when requested for credentials for a cuit' do
      context 'and there are none' do
        before do
          described_class.instance_variable_set("@authorized_cuits", [])
        end

        it 'raises an error' do
          expect { described_class.for('some_cuit') }.to raise_exception(::Bravo::MissingCredentials,
            'missing credentials for some_cuit')
        end
      end
    end
  end
end
