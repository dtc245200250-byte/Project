package com.codegym;

/**
 * Performs the four basic arithmetic operations.
 */
public class Calculator {

    public double calculate(double firstOperand, double secondOperand, String operator) {
        return switch (operator) {
            case "add" -> firstOperand + secondOperand;
            case "subtract" -> firstOperand - secondOperand;
            case "multiply" -> firstOperand * secondOperand;
            case "divide" -> {
                if (secondOperand == 0.0d) {
                    throw new ArithmeticException("Không thể chia cho 0.");
                }
                yield firstOperand / secondOperand;
            }
            default -> throw new IllegalArgumentException("Phép toán không hợp lệ.");
        };
    }
}
